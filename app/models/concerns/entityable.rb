module Entityable
    extend ActiveSupport::Concern


    module ClassMethods
        def page(input)
            #得到总条数
            totalCount=self.count
         
            data=nil
            if(totalCount>0)
                #取参数
                index=input[:PageIndex].to_i
                size=input[:PageSize].to_i
                #获取分页数据
                data=self.offset((index-1)*size).limit(size)
                #计算页数
                pageCount=totalCount/size
                
                #返回结果
                result={
                    :Data=>data,
                    :TotalCount=>totalCount,
                    :PageCount=>totalCount%size==0?pageCount:pageCount+1
                }
               
            else
                result={
                    :Data=>[],
                    :TotalCount=>0,
                    :PageCount=>1
                }
            end
        end
    end
end
