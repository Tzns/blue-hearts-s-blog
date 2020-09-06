class MBlog < ApplicationRecord
  self.table_name="m_blog"
  self.primary_key = "id"
  
  #点击数加1
  def addClickCount
    count=self[:click_count]
    self[:click_count]=count+1
    self.save
  end
end
