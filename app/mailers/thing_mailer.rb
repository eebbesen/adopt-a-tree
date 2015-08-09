class ThingMailer < ActionMailer::Base
  default from: 'info@brewingabetterforest.com'
  ACTION = 'water'

  def reminder(thing)
    @thing = thing
    mail(to: @thing.user.email, subject: "Remember to #{ACTION} #{ThingNameHelper.thing_name(@thing, 'your')}")
  end

  def abandon(thing, abandoner_email)
    mail(to: abandoner_email, subject: "Thank you for your taking care of a #{ThingNameHelper::THINGY}, we'll miss you!",
      body: "We'd love to have you back when you are able to adopt a #{ThingNameHelper::THINGY} again.")
  end

  def adopt(thing)
    mail(to: thing.user.email, subject: "Thank you for adopting #{ThingNameHelper.thing_name(thing, 'a')}!",
      body: "We'll send reminders to #{ACTION} #{ThingNameHelper.thing_name(thing, 'your')}.\nAsk your friends and neighbors to help, too!")
  end
end

class ThingNameHelper
  THINGY = 'tree'

  def self.thing_name(thing, modifier=nil)
    if !thing.nil? && thing.respond_to?(:name) && !thing.name.nil?
      thing.name
    else
      modifier.blank? ? THINGY : "#{modifier} #{THINGY}"
    end
  end
end
