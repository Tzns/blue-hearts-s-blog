module ApplicationHelper
    $menus=[
        {:id=>1, :name=>"后台管理", :pid=>0, :action=>"", :controller=>"back", :ico=>nil},
        {:id=>2, :name=>"数据", :pid=>1 ,:action=>"index", :controller=>"back", :ico=>"home"},
        {:id=>3, :name=>"文章管理", :pid=>1, :action=>"word", :controller=>"back", :ico=>"word"}
        ]
    #获取一个Guid
    def newId 
      SecureRandom.uuid
    end
    
    
    
    def newHex(len=10)
      SecureRandom.hex(len)
    end
    
    def deep_copy(o)
      Marshal.load(Marshal.dump(o))
    end
    
    
  def getPageData
    r=[]
    (1..20).each do |num|
      obj={
        :id=>num,
        :title=>"测试标题#{num}",
        :content=>"##测试正文#{num}"
      }
      r.push obj
    end
    return r
  end
  
  def err(mes)
    result={
      :IsSuccess=>false,
      :Data=>nil,
      :Info=>mes
    }
    render json:result
  end
  #成功的异步返回
  def succ(data,mes='')
    result={
      :IsSuccess=>true,
      :Data=>data,
      :Info=>mes
    }
    render json:result
  end
  
end
