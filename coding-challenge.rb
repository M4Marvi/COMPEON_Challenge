# SMS can only be a maximum of 160 characters.
# If the user wants to send a message bigger than that, we need to break it up.
# We want a multi-part message to have this added to each message:
# " - Part 1 of 2"
# You need to fix this method, currently it will crash with > 160 char messages.
MAX_SMS_LENGTH = 160

def send_sms_message(text)
  if text.length > MAX_SMS_LENGTH
    number_of_divisions = (text.length.to_f / MAX_SMS_LENGTH).ceil
    text_truncate_length = text.length / number_of_divisions
    text_starting_index = 0
    (1..number_of_divisions).each do |i|
      text_to_send = "- Part #{i} of #{number_of_divisions} " + text[text_starting_index..text_truncate_length]
      text_starting_index = text_truncate_length
      text_truncate_length += text_truncate_length
      deliver_message_via_carrier(text_to_send, to, from)
    end
  else
    deliver_message_via_carrier(text, to, from)
  end
end

# This method actually sends the message via a SMS carrier
# This method works, __you don't change it__,
def deliver_message_via_carrier(text, to, from)
  SMS_CARRIER.deliver_message(text, to, from)
end
