User.delete_all
hiroshi = User.create!(name: 'ひろし')
hanako = User.create!(name: 'はなこ')
takashi = User.create!(name: 'たかし')

Message.delete_all
Message.create(from_user: takashi, to_user: hanako, content: 'こんにちは、はなこ')
Message.create(from_user: hanako, to_user: takashi, content: '何のようですか？たかし')
Message.create(from_user: hanako, to_user: hiroshi, content: 'こんばんは、ひろし')
Message.create(from_user: hanako, to_user: hiroshi, content: '今ちょっといいですか？')
Message.create(from_user: hiroshi, to_user: takashi, content: 'たかし、来週ひま？')
Message.create(from_user: hiroshi, to_user: hanako, content: '何だい、はなこ？')
