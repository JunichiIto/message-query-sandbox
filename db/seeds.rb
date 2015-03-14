User.delete_all
hiroshi = User.create!(name: 'ひろし')
hanako = User.create!(name: 'はなこ')
takashi = User.create!(name: 'たかし')

Message.delete_all
Message.create(from_user_id: takashi.id, to_user_id: hanako.id, content: 'こんにちは、はなこ')
Message.create(from_user_id: hanako.id, to_user_id: takashi.id, content: '何のようですか？たかし')
Message.create(from_user_id: hanako.id, to_user_id: hiroshi.id, content: 'こんばんは、ひろし')
Message.create(from_user_id: hanako.id, to_user_id: hiroshi.id, content: '今ちょっといいですか？')
Message.create(from_user_id: hiroshi.id, to_user_id: takashi.id, content: 'たかし、来週ひま？')
Message.create(from_user_id: hiroshi.id, to_user_id: hanako.id, content: '何だい、はなこ？')
