module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    icon = "<i class=\"#{column == sort_column ? "current #{sort_direction}" : "visible-xs"}\"></i>"
    "#{link_to(title, {:sort => column, :direction => direction})}#{icon}"
  end
  
  def preview(inode)
    type = inode.content_type[/^[^\/]+/].to_sym
    ext = inode.content_type[/(?<=\/)(.+$)/].to_sym
    case type
    when :text
      case ext
      when :html, :htm then
        raw "<div>#{open(inode.uri, "r:iso8859-1").read}</div>"
      when :ruby, :java, :js, :python, :scss, :php, :lua, :html, :json, :go, :sql, :yaml, :text, :coffee then
        CodeRay.scan(open(inode.uri, "r:UTF-8"), ext).div(:line_numbers => :table, :css => :class)
      else
        raw "<div class=\"code\">#{File.read(inode.uri)}</div>"
      end        
    when :image
      raw "<img src=\"#{preview_inode_path(inode)}\" class=\"img-thumbnail\" />"
    when :application
      if :pdf == ext
        raw "<iframe src=\"#{preview_inode_path(inode)}\" width='860' height='800' border='0' style='border:none'></iframe>"
      end
    else
      "Binary File [#{inode.uri}]" 
    end
  end
end
