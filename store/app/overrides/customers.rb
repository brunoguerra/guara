#encoding: utf-8
#Deface::Override.new(:virtual_path => "guara/customers/_navbar",
#					 :name => "menu_emails_da_loja",
#					 :insert_bottom => ".nav-collapse .nav",
#					 :text =>"
#					 	<li <%= 'class=active' if active == :search %> ><%= link_to t(\"emails_no_clients\"), customers_path %></li>
#					 ")