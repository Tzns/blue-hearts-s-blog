class BackController < ApplicationController
    before_filter :load_application_wide_varibales
    private
      def load_application_wide_varibales
        controller=params[:controller]
        action=params[:action]

        
        if !sys_user_signed_in?
          return redirect_to "/sys_users/sign_in"
        end
        
        
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
    
    def index
        p ""
        @blog_total_count=MBlog.count
        @blog_click_total_count=MBlog.sum(:click_count)
        max=MBlog.pluck("max(click_count)").first.to_i
        min=MBlog.pluck("min(click_count)").first.to_i
        @blog_click_max=MBlog.find_by(click_count: max)[:title]
        @blog_click_min=MBlog.find_by(click_count: min)[:title]
        
        cvtSql="CONVERT(varchar(100), created_at, 111)"
        r={}
        arr= MBlog
                .group(cvtSql)
                .order("#{cvtSql} desc")
                .limit(10)
                .pluck("#{cvtSql} dt","count(created_at) ct")
                .to_a
        arr.each do |m|
            r[Date.parse(m[0])]=m[1]
        end
        @line_data=r
    end
    
    def word
    end
    
    def _insert_blog
        title=params[:title]
        content=params[:content]
        if title==""
            return err "标题不可为空"
        end
        m=MBlog.find_by(title: title)
        if m!=nil
            return err "已存在相同标题文章"
        end
        add=MBlog.new({
            :title=>title,
            :word_content=>content,
            :click_count=>rand(1..1000),
        })
        if add.save
            return succ nil,"添加成功"
        else
            return err "添加失败"
        end
    end
    
    def _update_blog
        id=params[:id]
        title=params[:title]
        content=params[:content]
        if id==""
            return err "不可为空"
        end
        if title==""
            return err "标题不可为空"
        end
        m=MBlog.find_by(id: id)
        if m==nil
            return err "没有找到该文章"
        end
        m[:title]=title
        m[:word_content]=content
        
        if m.save
            return succ nil,"修改成功"
        else
            return err "修改失败"
        end
    end
    
    def _del_blog
        id=params[:id]
        if id==""
            return err "不可为空"
        end
        m=MBlog.find_by(id: id)
        if m==nil
            return err "没有找到该文章"
        end
        if m.delete()
            return succ nil,"删除成功"
        else
            return err "删除失败"
        end
    end
   
    
    
    
end