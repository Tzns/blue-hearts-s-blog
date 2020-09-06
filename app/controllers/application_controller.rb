class ApplicationController < ActionController::Base

  before_filter :sessions_set
  include ApplicationHelper
  protect_from_forgery with: :exception
  def after_sign_in_path_for(resource)
      "/back/index"
  end
  
  def after_sign_out_path_for(resource)
    "/sys_users/sign_in"
  end
  
  def after_sign_up_path_for(resource)
    "/back/index"
  end
  #根据当前用户设置一些信息
  private
    def sessions_set
      controller=params[:controller]
      action=params[:action]
      
      
      #菜单高亮
      menuModels=deep_copy $menus
      #当前菜单模型
      currAction=menuModels.find{|a| a[:controller]==controller and a[:action]==action}
      @currAction=currAction

      #p menuModels.select{|a| a[:pid]==36}
      menuModels.each do |m|
        m.delete(:Active)
        # p "#{m[:controller]}-#{controller}"
        if m[:pid]==0 and m[:controller]==controller
          m.store(:Active,true)
          next
        end
        if m[:controller]==controller and m[:action]==action
           m.store(:Active,true)
        end
      end
      @menuModels=menuModels
      
      
  end
  
  
  
  
  
end
