#  Deface::Override.new(:virtual_path=>"spree/admin/shared/_header",
#     :name=>"change_logo",
#     :remove=>"erb[loud]:contains(link_to)");

#------------------------- Product form customization -----------------------

Deface::Override.new(:virtual_path => "spree/admin/products/_form",
    :name => "remove_promotionable",
    :replace => "[data-hook='admin_product_form_promotionable']",
    :text => "<div data-hook='admin_product_form_file_up_load'>
        <%= f.field_container :file_up_load, class: ['form-group'] do %>
          <%= f.label :file_up_load, Spree.t(:file_up_load) %>
          <%= f.error_message_on :file_up_load %>
          <%= f.check_box :file_up_load, class: 'form-control' %>
        <% end %>
      </div>")

Deface::Override.new(:virtual_path => "spree/admin/products/_form",
    :name => "remove_shipping_specs",
    :remove => "div#shipping_specs")  

#------------------------- option_types view customization ----------------------

Deface::Override.new(:virtual_path=>"spree/admin/option_types/index",
    :name=>"replace_option_types_any",
    :replace=>"table",
    :text=>"<table class='table sortable' id='listing_option_types' data-hook data-sortable-link='<%= update_positions_admin_option_types_url %>'>
        <thead>
            <tr data-hook='option_header'>
            <th class='no-border'></th>
            <th><%= Spree.t(:name) %></th>
            <th><%= Spree.t(:presentation) %></th>
            <th><%= Spree.t(:description) %></th>
            <th><%= Spree.t(:option_case) %></th>
            <th class='actions'></th>
            </tr>
        </thead>
        <tbody>
            <% @option_types.each do |option_type| %>
            <tr class='spree_option_type <%= cycle('odd', 'even')%>' id='<%= spree_dom_id option_type %>' data-hook='option_row'>
                <td class='move-handle text-center'>
                    <span class='icon icon-move handle'></span>
                </td>
                <td><%= option_type.name %></td>
                <td class='presentation'><%= option_type.presentation %></td>
                <td class='description'><%= option_type.description %></td>
                <td class='option_case'><%= option_type.spree_option_case_id %></td>
                <td class='actions actions-2 text-right'>
                    <%= link_to_edit(option_type, class: 'admin_edit_option_type', no_text: true) if can?(:edit, option_type) %>
                    <%= link_to_delete(option_type, no_text: true) if can?(:delete, option_type) %>
                </td>
            </tr>
            <% end %>
        </tbody>
        </table>") 

#
Deface::Override.new(:virtual_path => "spree/admin/option_types/_form",
    :name => "replace_option_type_form_fields",
    :replace => "[data-hook='admin_option_type_form_fields']",
    :text => "<div data-hook='admin_option_type_form_fields' class='row'>
            <div class='col-xs-12 col-md-4'>
                <%= f.field_container :name, class: ['form-group'] do %>
                <%= f.label :name, Spree.t(:name) %> <span class='required'>*</span>
                <%= f.text_field :name, class: 'form-control' %>
                <%= f.error_message_on :name %>
                <% end %>
            </div>
            <div class='col-xs-12 col-md-4'>
                <%= f.field_container :presentation, class: ['form-group'] do %>
                <%= f.label :presentation, Spree.t(:presentation) %> <span class='required'>*</span>
                <%= f.text_field :presentation, class: 'form-control' %>
                <%= f.error_message_on :presentation %>
                <% end %> 
            </div>
            <div class='col-xs-12 col-md-4'>
                <%= f.field_container :option_case, class: ['form-group'] do %>
                <%= f.label :type, Spree.t(:option_case) %>
                <%= f.collection_select(:spree_option_case_id, @option_cases, :id, :name, {  }, { class: 'select2' }) %>
                <%= f.error_message_on :option_case %>
                <% end %>
            </div>  
            <div class='col-xs-12 col-md-12'>
                <%= f.field_container :description, class: ['form-group'] do %>
                <%= f.label :description, Spree.t(:description) %> <span class='required'>*</span>
                <%= f.text_area :description, class: 'form-control' %>
                <%= f.error_message_on :description %>
                <% end %> 
            </div>
        ")


Deface::Override.new(:virtual_path => "spree/admin/option_types/edit",
    :name => "remove_option_values_if_comment",
    :surround => "table.table-condensed",
    :text => "<% if @option_type.spree_option_case_id == 1 %>
                <%= render_original %>
            <% end %>")

Deface::Override.new(:virtual_path => "spree/admin/option_types/edit",
    :name => "add_validation_of_add_new_option_value_button",
    :surround => "span#new_add_option_value",
    :text => "<% if @option_type.spree_option_case_id == 1 %>
                <%= render_original %>
            <% end %>")

Deface::Override.new(:virtual_path => "spree/admin/option_types/edit",
    :name => "add_image_to_table_header",
    :insert_after => "erb[loud]:contains('.t(:display)')",
    :text => "<th><%= Spree.t(:image) %></th>")            

Deface::Override.new(:virtual_path => "spree/admin/option_types/_option_value_fields",
    :name => "add_attached_image_field",
    :insert_after => "td.presentation",
    :text => "<td class='image row'>
                <div class = 'col-md-6 col-sm-12'>
                    <%= f.text_field :image_file_name, readonly:true, class: 'form-control' %>
                </div>
                <div class = 'col-md-6 col-sm-12'>
                    <%= f.file_field :image %>
                </div>
            </td>")

# Deface::Override.new(:virtual_path => "spree/admin/option_types/_option_value_fields",
#     :name => "add_attached_image_field",
#     :replace => "tr.option_value",
#     :text => "<tr class='option_value fields row' id='spree_<%= dom_id(f.object) %>' data-hook='option_value'>
#                 <td class='move-handle text-center'>
#                     <span class='icon icon-move handle'></span>
#                     <%= f.hidden_field :id %>
#                 </td>
#                 <td class='name'><%= f.text_field :name, class: 'form-control' %></td>
#                 <td class='presentation'><%= f.text_field :presentation, class: 'form-control' %></td>
#                 <td class='image row'>
#                     <div class = 'col-md-6 col-sm-12'>
#                         <%= f.text_field :image_file_name, class: 'form-control' %>
#                     </div>
#                     <div class = 'col-md-6 col-sm-12'>
#                         <%= f.file_field :image %>
#                     </div>
#                 </td>
#                 <td class='actions actions-1 text-center'><%= link_to_icon_remove_fields f %></td>
#             </tr>")

Deface::Override.new(:virtual_path => "spree/admin/variants/_form",
    :name => "add_validation_comment",
    :surround => "[data-hook='presentation']",
    :text => "<% if option_type.spree_option_case_id == 1 %>
                <%= render_original %>
            <% end %>")

Deface::Override.new(:virtual_path => "spree/admin/shared/_main_menu",
    :name => "_main_menu_remove_orders",
    :remove => "erb[loud]:contains('ORDER_TABS')")     

Deface::Override.new(:virtual_path => "spree/admin/shared/_main_menu",
    :name => "_main_menu_remove_tab_reports",
    :remove => "erb[loud]:contains('REPORT_TABS')")             

Deface::Override.new(:virtual_path => "spree/admin/shared/_main_menu",
    :name => "_main_menu_remove_tab_returns",
    :remove => "erb[loud]:contains('.t(:returns)')")             

Deface::Override.new(:virtual_path => "spree/admin/shared/_main_menu",
    :name => "_main_menu_remove_tab_configuration",
    :remove => "erb[loud]:contains('.t(:configurations)')")

Deface::Override.new(:virtual_path => "spree/admin/shared/_main_menu",
    :name => "_main_menu_remove_tab_promotions",
    :remove => "erb[loud]:contains('.t(:promotions)')")    

Deface::Override.new(:virtual_path => "spree/layouts/spree_application",
    :name => "_login_header_remove",
    :remove => "erb[loud]:contains('spree/shared/header')")

Deface::Override.new(:virtual_path => "spree/admin/shared/_main_menu",
    :name => "_main_menu_add_tab_coupon",
    :insert_before => "erb[silent]:contains('if can? :admin, Spree::Admin::ReportsController')",
    :text => "<ul class='nav nav-sidebar'>
                <%= tab :coupons, icon: 'file'  %>
                </ul>")      
# Deface::Override.new(:virtual_path => "spree/admin/shared/sub_menu/_product",
#     :name => "_main_menu_add_tab_orders",
#     :insert_before => "erb[loud]:contains(':properties')",
#     :text => "<%= tab :order_info_options %>")  

Deface::Override.new(:virtual_path => "spree/admin/shared/_product_tabs",
    :name => "remove_product_variant_tab_from_product_admin_tabs",
    :remove => "erb[loud]:contains('Spree.t(:variants)')")

Deface::Override.new(:virtual_path => "spree/admin/shared/_product_tabs",
    :name => "add_product_variant_type_tab_product_admin_tabs",
    :insert_before => "erb[loud]:contains('current == :properties')",
    :text => "<%= content_tag :li, class: ('active' if current == :product_variant_types) do %>
                <%= link_to_with_icon 'th-large', Spree.t(:variant_types),  spree.admin_product_product_variant_types_url(@product) %>
            <% end if can?(:admin, Spree::ProductVariantType) && !@product.deleted? %>")

Deface::Override.new(:virtual_path => "spree/admin/products/_add_stock_form",
    :name => "modify_variant_stock_form",
    :replace => "div.panel-body",
    :text => "<div class='panel-body'>
                <%= form_for [:admin, Spree::StockMovement.new], url: admin_stock_items_path do |f| %>
                    <div data-hook='admin_stock_movements_form_fields' class='row'>
                    <div class='col-xs-12 col-md-2'>
                        <div class='form-group'>
                        <%= f.field_container :quantity do %>
                            <%= f.label :quantity, Spree.t(:quantity) %>
                            <%= f.number_field :quantity, class: 'form-control', value: 1 %>
                        <% end %>
                        </div>
                    </div>
                    <div class='col-xs-12 col-md-5'>
                        <div class='form-group'>
                        <%= f.field_container :stock_location do %>
                            <%= label_tag :stock_location_id, Spree.t(:stock_location) %>
                            <%= select_tag 'stock_location_id', options_from_collection_for_select(@stock_locations, :id, :name),
                            class: 'select2' %>
                        <% end %>
                        </div>
                    </div>

                    <div class='col-xs-12 col-md-5'>
                        <div class='form-group'>
                        <%= f.field_container :variant_id do %>
                            <%= label_tag 'variant_id', Spree.t(:product) %>
                            <%= select_tag 'variant_id', options_from_collection_for_select([@variants[0]], :id, :name),
                            class: 'select2' %>
                        <% end %>
                        </div>
                    </div>
                    </div>

                    <div class='form-actions text-center' data-hook='buttons'>
                    <%= button Spree.t(:add_stock), 'plus' %>
                    </div>
                <% end %>
                </div>")
Deface::Override.new(:virtual_path => "spree/admin/products/stock",
    :name => "modify_stock_view_thead",
    :replace => "thead",
    :text => "<thead>
      <tr data-hook='admin_product_stock_management_index_headers'>
        <th colspan='2'><%= Spree.t(:product) %></th>
        <th colspan='3'><%= Spree.t(:stock_location_info) %></th>
      </tr>
    </thead>")


Deface::Override.new(:virtual_path => "spree/admin/products/stock",
    :name => "modify_stock_view_tbody",
    :replace => "tbody",
    :text => "<tbody>
      <% variant = @variants[0]%>
        <% if variant.stock_items.present? %>
          <tr id='<%= spree_dom_id variant %>' data-hook='admin_product_stock_management_index_rows'>
            <td class='image text-center'>
              <% if variant.images.present? %>
                <%= image_tag variant.images.first.attachment.url(:mini) %>
              <% end %>
            </td>
            <td>
              <%= variant.name %>
              <%= form_tag admin_product_variants_including_master_path(@product, variant, format: :js), method: :put, class: 'toggle_variant_track_inventory' do %>
                <div class='checkbox'>
                  <%= label_tag 'track_inventory_#{ 'variant.id' }' do %>
                    <%= check_box_tag 'track_inventory', 1, variant.track_inventory?,
                                      class: 'track_inventory_checkbox', id: 'track_inventory_#{ 'variant.id' }' %>
                    <%= Spree.t(:track_inventory) %>
                    <%= hidden_field_tag 'variant[track_inventory]', variant.track_inventory?,
                        class: 'variant_track_inventory',
                        id: 'variant_track_inventory_#{'variant.id'}' %>
                  <% end %>
                </div>
              <% end if can?(:update, @product) && can?(:update, variant) %>
            </td>

            <td colspan='3' class='stock_location_info'>
              <table class='table table-bordered no-marginb'>
                <thead>
                  <th><%= Spree.t(:stock_location) %></th>
                  <th class='text-center'><%= Spree.t(:count_on_hand) %></th>
                  <th class='text-center'><%= Spree.t(:backorderable) %></th>
                  <th class='actions text-center'></th>
                </thead>
                <tbody>
                  <% variant.stock_items.each do |item| %>
                    <% next unless @stock_locations.include?(item.stock_location) %>
                    <tr id='stock-item-<%= item.id %>'>
                      <td><%= item.stock_location.name %></td>
                      <td class='text-center'><%= item.count_on_hand %></td>
                      <td class='text-center'>
                        <%= form_tag admin_stock_item_path(item), method: :put, class: 'toggle_stock_item_backorderable' do %>
                          <%= check_box_tag 'stock_item[backorderable]', true,
                                item.backorderable?,
                                class: 'stock_item_backorderable',
                                id: 'stock_item_backorderable_#{'item.stock_location.id'}' %>
                        <% end if can? :update, item %>
                      </td>
                      <td class='actions actions-1 text-center'>
                        <%= link_to_with_icon('delete', Spree.t(:remove), [:admin, item], method: :delete, remote: true, class: 'icon_link btn btn-danger btn-sm', data: { action: :remove, confirm: Spree.t(:are_you_sure) }, no_text: true) if can? :destroy, item %>
                      </td>
                    </tr>
                  <% end %>
                </tbody>
              </table>
            </td>
        <% end %>
        </tr>

    </tbody>" )   

Deface::Override.new(:virtual_path => "spree/admin/products/_form",
    :name => "remove_variant_manage_form",
    :remove => "[data-hook='admin_product_form_multiple_variants']")