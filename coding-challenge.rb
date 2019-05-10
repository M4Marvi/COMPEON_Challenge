# SMS can only be a maximum of 160 characters.
# If the user wants to send a message bigger than that, we need to break it up.
# We want a multi-part message to have this added to each message:
# " - Part 1 of 2"
text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."

# You need to fix this method, currently it will crash with > 160 char messages.

def send_sms_message(text)
  puts text.length
  if text.length > 160
    number_of_divisions = (text.length.to_f / 160).ceil
    text_trucate_length = text.length / number_of_divisions
    j = 0
    (1..number_of_divisions).each do |i|
      text_to_send = "- Part #{i} of #{number_of_divisions} " + text[j..text_trucate_length]
      j = text_trucate_length
      text_trucate_length += text_trucate_length
      deliver_message_via_carrier(text_to_send, to, from)
    end
  else
    deliver_message_via_carrier(text, to, from)
  end
end
#deliver_message_via_carrier(text, to, from)

send_sms_message(text)

# This method actually sends the message via a SMS carrier
# This method works, __you don't change it__,
def deliver_message_via_carrier(text, to, from)
  SMS_CARRIER.deliver_message(text, to, from)
end
