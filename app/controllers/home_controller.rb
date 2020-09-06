class HomeController < ActionController::Base
    include ApplicationHelper
    
    def test
        #p MBlog.all
        #添加测试数据
        # r=[]
        # (1..10).each do |num|
        #     (1..rand(1..10)).each do |day|
        #         MBlog.new({
        #           :title=>"测试标题#{num}#{day}",
        #           :word_content=>"##测试正文#{num}#{day}",
        #           :click_count=>rand(1..1000),
        #           :created_at=>Date.new(2020,9, 1+day)
        #         }).save
        #     end
        # end
        # return r
    end
    
    def index
        
    end
    
    def info
        id=params[:id]
        model=MBlog.find_by(id: id)
        if model==nil
            return redirect_to "/404.html"
        end
        @model=model
    end
    
    
    def _getIndexPageData
        data=MBlog.order("created_at desc").page(params)
        
        return succ data,""
    end
end