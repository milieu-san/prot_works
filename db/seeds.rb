

taro = User.create(name: "taro",
                    nick_name: "taro",
                    email: "taro@taro.jp",
                    password: "123456",
                    confirmed_at: Time.now)

ziro = User.create(name: "ziro",
                    nick_name: "ziro",
                    email: "ziro@ziro.jp",
                    password: "123456",
                    confirmed_at: Time.now)

subro = User.create(name: "subro",
                    nick_name: "subro",
                    email: "subro@subro.jp",
                    password: "123456",
                    confirmed_at: Time.now)

momotaro = taro.prots.create(title: "桃太郎",
                             content: "昔ながらの物語\n桃から生まれた男が鬼を倒す\nレビュー受付",
                             private: false,
                             accepts_review: true)
momotaro.genres.create(name: "活劇")
momotaro.media_types.create(name: "絵本")

urasima = taro.prots.create(title: "浦島太郎",
                            content: "昔ながらの物語\n亀を助けた男が竜宮城へ行く\nレビュー許容していません",
                            private: false,
                            accepts_review: false)
urasima.genres.create(name: "ミステリー")
urasima.genres.create(name: "理不尽")
urasima.media_types.create(name: "ドラマ")
urasima.media_types.create(name: "映画")

private_prot = taro.prots.create(title: "誰からも閲覧できないプロット",
                             content: "プライベート設定しているのでtaro以外からは存在を確認できません",
                             private: true,
                             accepts_review: true)
private_prot.genres.create(name: "プライベートプロット")
private_prot.media_types.create(name: "未設定")

super_momotaro = ziro.prots.create(title: "スーパー桃太郎",
                             content: "昔ながらの物語を改良\ntaroさんに影響を受けました\nレビュー受付",
                             private: false,
                             accepts_review: true)
super_momotaro.genres.create(name: "活劇")
super_momotaro.media_types.create(name: "絵本")


momotaro.nodes.create(title: "桃太郎",
                      body: "本文",
                      position: 0)

urasima.nodes.create(title: "浦島太郎",
                      body: "本文",
                      position: 0)

super_momotaro.nodes.create(title: "スーパー桃太郎",
                            body: "本文",
                            position: 0)

private_prot.nodes.create(title: "プライベート",
                          body: "本文",
                          position: 0)

momoreview = momotaro.reviews.create(title: "hogehogeについて",
                                    content: "hogehogeのfugafugaがとてもよかったです！\n
                                              具体的にはfugafugaがhogehogeなのは新しいと思いました。\n
                                              しかし、気になった点が幾つかありました。\n
                                              --で--と書いてあるのに==だと==になってます。\n
                                              これだと主人公の言っていることに一貫性がなくて共感できません。",
                                    user_id: ziro.id)

momoreview.comments.create(body: "コメントありがとうございます！
                                  \nたしかに！ と思ったので参考にさせていただきます！",
                          user_id: taro.id)
