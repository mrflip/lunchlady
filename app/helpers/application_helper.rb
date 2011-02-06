 module ApplicationHelper

   # Help individual pages to set their HTML titles
   def title(text)
     @title = text
   end

   # This template will handle its own rows
   def multirow
     @multirow = true
   end

   # Help individual pages to set their HTML meta descriptions
   def description(text)
     content_for(:description){ text }
   end

   #
   # Link to a resource by its titleized text
   #
   # link_to_rsrc @dataset  => <a href="/datasets/dataset-handle" dataset.title
   # link_to_rsrc Dataset   => /datasets
   #
   def link_to_rsrc rsrc, options={}
     return '' unless rsrc
     case rsrc
     when ActiveRecord::Base then dest = rsrc                        ; text = rsrc.titleize
     when Class              then dest = url_for(rsrc.to_s.tableize) ; text = rsrc.to_s.titleize.pluralize
     when Symbol             then dest = rsrc                        ; text = rsrc.to_s.titleize.pluralize
     else                         dest = rsrc
     end
     link_to(text, dest, options)
   end
 end
