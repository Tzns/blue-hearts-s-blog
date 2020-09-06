class BackController < ApplicationController
    before_filter :authenticate_sys_user!
    
    def index
        user=current_sys_user
        query=MBlog.where(create_id: user[:id])
        @blog_total_count=query.count
        @blog_click_total_count=query.sum(:click_count)
        max=query.pluck("max(click_count)").first.to_i
        min=query.pluck("min(click_count)").first.to_i
        if max!=0
            @blog_click_max=query.find_by(click_count: max)[:title]
        end
        if min!=0
            @blog_click_min=query.find_by(click_count: min)[:title]
        end
        
        cvtSql="CONVERT(varchar(100), created_at, 111)"
        r={}
        arr= query.group(cvtSql)
                  .order("#{cvtSql} desc")
                  .limit(10)
                  .pluck("#{cvtSql} dt","count(created_at) ct")
                  .to_a
        arr.each do |m|
            r[Date.parse(m[0])]=m[1]
        end
        @line_data=r
    end
    
    
    def _getDataPageData
        user=current_sys_user
        data=MBlog.where(create_id: user[:id]).order("created_at desc").page(params)
        
        return succ data,""
    end
    
    
    def word
    end
    
    def _insert_blog
        title=params[:title]
        content=params[:content]
        if title==""
            return err "标题不可为空"
        end
        user=current_sys_user
        m=MBlog.find_by(title: title)
        if m!=nil
            return err "已存在相同标题文章"
        end
        add=MBlog.new({
            :title=>title,
            :word_content=>content,
            :click_count=>rand(1..1000),
            :create_id=>user[:id]
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
        user=current_sys_user
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