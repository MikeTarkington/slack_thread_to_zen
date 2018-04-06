Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/' => 'message#slash_command'

  # root 'message#slash_command'

  get 'message/slack_thread'

  post 'message/zd_comment'

end
