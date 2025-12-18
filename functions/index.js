const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.onNewGroupMessage = functions.firestore
    .document('group_chats/{groupId}/messages/{messageId}')
    .onCreate(async (snapshot, context) => {
        const msg = snapshot.data();
        const groupId = context.params.groupId;

        const groupRef = admin.firestore().collection('group_chats').doc(groupId);
        const groupDoc = await groupRef.get();

        if (!groupDoc.exists) return null;

        const groupData = groupDoc.data();
        const memberIds = groupData.users;
        const groupName = groupData.name;

        // 1. Update Unread Counts in Firestore first
        const updates = {};
        memberIds.forEach(uid => {
            if (uid !== msg.senderId) {
                updates[`unreadCount.${uid}`] = admin.firestore.FieldValue.increment(1);
            }
        });
        await groupRef.update(updates);

        // 2. Prepare notifications
        const notifications = memberIds.map(async (uid) => {
            if (uid === msg.senderId) return;

            const userDoc = await admin.firestore().collection('users').doc(uid).get();
            if (!userDoc.exists) return;

            const token = userDoc.data().fcmToken;

            // Fix: Get the fresh count by adding 1 to the snapshot we took earlier
            const freshUnseenCount = (groupData.unreadCount?.[uid] || 0) + 1;

            if (token) {
                const messagePayload = {
                    token: token,
                    notification: {
                        title: groupName,
                        body: `${msg.senderName}: ${msg.text || (msg.mediaType === 'video' ? '🎥 Vidéo' : '📷 Image')}`,
                    },
                    data: {
                        groupId: groupId, // Used for navigation in Flutter
                        click_action: "FLUTTER_NOTIFICATION_CLICK",
                    },
                    android: {
                        notification: {
                            channelId: "chat_messages", // Must match your Flutter channel ID
                            notificationCount: freshUnseenCount,
                            priority: "high",
                        },
                    },
                    apns: {
                        payload: {
                            aps: {
                                badge: freshUnseenCount, // Sets the red dot on iPhone icons
                                sound: "default",
                            },
                        },
                    },
                };
                return admin.messaging().send(messagePayload);
            }
        });

        return Promise.all(notifications);
    });