class FeedMailer < ApplicationMailer
  def feed_mail(feed)
    @feed = feed
    mail to: "daikons.msn36@gmail.com", subject: "投稿をしました"
  end
end
