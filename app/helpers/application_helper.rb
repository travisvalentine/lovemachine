module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Lovemachine"      
    end
  end
end
