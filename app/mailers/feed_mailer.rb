class FeedMailer < ApplicationMailer
  def feed_mail(feed)
    @feed = feed
    mail to: "a.p.l.daikons.msn36@gmail.com", subject: "投稿をしました"
  end
end
