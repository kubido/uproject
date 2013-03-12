class ApplicationController  < Application

  ['/matrikulasi', "/members", "/profile", "/download", "/message"].each do |path|
    before path do
      if session[:login].nil?
        session[:flash] = {type: 'warning', message: "Silahkan login Terlebih dahulu"} 
        redirect '/' 
      end
    end
  end

  get "/" do 
    @messages = Message.all
    haml :index, :layout => !request.xhr?
  end

  get "/channel" do
    haml :channel
  end

  post "/facebook_auth" do
    @user = User.where(:uid => params[:uid]).first
    unless @user.present?
      @success = User.register_facebook(params)
      @user = User.where(:uid => params[:uid]).first
    end

    session[:login] = @user
    @messages = Message.all
    haml :index, :layout => !request.xhr?
  end

  post "/logout" do
    session.clear
    redirect '/'
  end

  get "/matrikulasi" do
    if current_user.profile.present?
      @survei = current_user.survei.present? ? current_user.survei : current_user.build_survei
      haml :matrikulasi      
    else
      session[:flash] = {type: 'warning', message: "Silahkan isi profile terlebih dahulu"}
      redirect '/profile'
    end
  end

  post '/matrikulasi' do
    puts params[:matrikulasi]
    redirect '/profile' unless current_user.profile.present?
    @survei = current_user.build_survei(params[:matrikulasi])
    if @survei.save
      session[:flash] = {type: 'success', message: "Terima kasih"}
      redirect '/'
    else
      session[:flash] = {type: 'error', message: @survei.errors.full_messages.join(", ")}
      redirect '/matrikulasi'
    end
  end

  get '/profile' do
    @profile = current_user.profile.present? ? current_user.profile : current_user.build_profile
    haml :profile
  end

  post '/profile' do
    @profile = current_user.build_profile(params[:profile])
    if @profile.save
      session[:flash] = {type: 'success', message: "Terima kasih"}
    else
      session[:flash] = {type: 'error', message: @profile.errors.full_messages.join(", ")}      
    end
    redirect '/profile'
  end

  post '/message' do
    redirect '/' if !request.xhr?
    @message = current_user.messages.new(message: params[:message])
    @message.save
    haml :message, :layout => false
  end

  get '/download' do
    @download_links = DownloadLink.where(link_type: params[:t]) unless params[:t] == "source_code"
    haml :'download/index'
  end

  post '/download' do
    puts params[:download_link]
    @download_link = DownloadLink.new(params[:download_link])
    if @download_link.save
      session[:flash] = {type: 'success', message: "Data berhasil disimpan"}
    else
      session[:flash] = {type: 'error', message: @download_link.errors.full_messages.join(", ")}      
    end
    redirect '/download'
  end

  get '/members' do
    haml :members
  end
end