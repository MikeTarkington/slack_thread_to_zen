search_resp = {"ok"=>true, "query"=>"345", "messages"=>{"total"=>1, "pagination"=>{"total_count"=>1, "page"=>1, "per_page"=>20, "page_count"=>1, "first"=>1, "last"=>1}, "paging"=>{"count"=>20, "total"=>1, "page"=>1, "pages"=>1}, "matches"=>[{"next"=>{"type"=>"message", "user"=>"U8U2BS4JC", "username"=>"michael.tarkington", "ts"=>"1523167540.000017", "text"=>"zd 678", "iid"=>"7374f01e-5394-437e-810f-8e8e037ae37d", "permalink"=>"https://ddtest-workspace.slack.com/archives/C8VH6NR2A/p1523167540000017?thread_ts=1523098535.000028"}, "next_2"=>{"type"=>"message", "user"=>"U8U2BS4JC", "username"=>"michael.tarkington", "ts"=>"1523167752.000021", "text"=>"zd 890", "iid"=>"794d4f08-af5c-4d9d-8cb7-ad540ea815e9", "permalink"=>"https://ddtest-workspace.slack.com/archives/C8VH6NR2A/p1523167752000021?thread_ts=1523098535.000028"}, "type"=>"message", "user"=>"U8U2BS4JC", "username"=>"michael.tarkington", "ts"=>"1523098535.000028", "text"=>"345", "iid"=>"7d73c254-4c1b-4b37-ae6a-8415d6a7415d", "permalink"=>"https://ddtest-workspace.slack.com/archives/C8VH6NR2A/p1523098535000028?thread_ts=1523098535.000028", "team"=>"T8UQY4WJH", "channel"=>{"id"=>"C8VH6NR2A", "is_channel"=>true, "is_group"=>false, "is_im"=>false, "name"=>"general", "is_shared"=>false, "is_org_shared"=>false, "is_ext_shared"=>false, "is_private"=>false, "is_mpim"=>false, "pending_shared"=>[], "is_pending_ext_shared"=>false}}], "refinements"=>[]}}

def parse_timestamp(search_resp)
  #get to the permalink and pull out the ts value to be used for finding corersponding matches in the channel hist parser

  p timestamp = /(?<=thread_ts=)\d{10}.\d{6}/.match(search_resp['messages']['matches'][0]['permalink'])[0]
end

chan_hist_resp = {"ok"=>true, "messages"=>[{"type"=>"message", "user"=>"U8U2BS4JC", "text"=>"zd another", "thread_ts"=>"1523098535.000028", "parent_user_id"=>"U8U2BS4JC", "ts"=>"1523168134.000077"}, {"type"=>"message", "user"=>"U8U2BS4JC", "text"=>"zd stuff", "thread_ts"=>"1523098535.000028", "parent_user_id"=>"U8U2BS4JC", "ts"=>"1523167920.000054"}, {"type"=>"message", "user"=>"U8U2BS4JC", "text"=>"zd 890", "thread_ts"=>"1523098535.000028", "parent_user_id"=>"U8U2BS4JC", "ts"=>"1523167752.000021"}, {"type"=>"message", "user"=>"U8U2BS4JC", "text"=>"zd 678", "thread_ts"=>"1523098535.000028", "parent_user_id"=>"U8U2BS4JC", "ts"=>"1523167540.000017"}, {"type"=>"message", "user"=>"U8U2BS4JC", "text"=>"345", "thread_ts"=>"1523098535.000028", "reply_count"=>4, "replies"=>[{"user"=>"U8U2BS4JC", "ts"=>"1523167540.000017"}, {"user"=>"U8U2BS4JC", "ts"=>"1523167752.000021"}, {"user"=>"U8U2BS4JC", "ts"=>"1523167920.000054"}, {"user"=>"U8U2BS4JC", "ts"=>"1523168134.000077"}], "subscribed"=>true, "last_read"=>"1523168134.000077", "unread_count"=>0, "ts"=>"1523098535.000028"}, {"type"=>"message", "user"=>"U8U2BS4JC", "text"=>"and finding out if the thread works on it as well", "thread_ts"=>"1522039112.000073", "parent_user_id"=>"U8U2BS4JC", "ts"=>"1522039130.000026"}, {"type"=>"message", "user"=>"U8U2BS4JC", "text"=>"starting a second conversation", "thread_ts"=>"1522039112.000073", "reply_count"=>1, "replies"=>[{"user"=>"U8U2BS4JC", "ts"=>"1522039130.000026"}], "subscribed"=>true, "last_read"=>"1522039130.000026", "unread_count"=>0, "ts"=>"1522039112.000073"}, {"type"=>"message", "user"=>"U8U2BS4JC", "text"=>"aaaaand here’s a thread", "thread_ts"=>"1516264522.000504", "parent_user_id"=>"U8U2BS4JC", "ts"=>"1516266059.000223"}, {"type"=>"message", "user"=>"U8U2BS4JC", "text"=>"here’s a test message to find in the api test", "thread_ts"=>"1516264522.000504", "reply_count"=>1, "replies"=>[{"user"=>"U8U2BS4JC", "ts"=>"1516266059.000223"}], "subscribed"=>true, "last_read"=>"1516266059.000223", "unread_count"=>0, "ts"=>"1516264522.000504"}, {"user"=>"U8U2BS4JC", "text"=>"<@U8U2BS4JC> has joined the channel", "type"=>"message", "subtype"=>"channel_join", "ts"=>"1516262808.000154"}], "has_more"=>false}


def parse_chan_hist(chan_hist_resp, timestamp)
  #pull the needed values of the json object first finding matches for the thread ts
  #then for each match found, collect the correct pieces of info to be send to zd
  thread_messages = []
  chan_hist_resp['messages'].each do |message|
    if message['thread_ts'].to_i == timestamp.to_i then thread_messages << message end
  end
  p thread_messages
end

def thread_msgs_content(thread_messages)
  thread_msgs_content = []
  formed_msg = {}
  thread_messages.each do |msg|
    formed_msg[:user] = msg['user']
    formed_msg[:body] = msg['text']
    formed_msg[:time] = msg['ts']
    thread_msgs_content << formed_msg
  end
  p '*' * 80
  p thread_msgs_content
end

timestamp = parse_timestamp(search_resp)
thread_messages = parse_chan_hist(chan_hist_resp, timestamp)
thread_msgs_content(thread_messages)
