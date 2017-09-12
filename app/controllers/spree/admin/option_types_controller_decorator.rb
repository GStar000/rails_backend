Spree::Admin::OptionTypesController.class_eval do
    before_action :load_data

    def location_after_save
        
        if @option_type.comment
            @option_type.option_values.delete_all
        end

        if @option_type.created_at == @option_type.updated_at
            edit_admin_option_type_url(@option_type)
        else
            admin_option_types_url
        end
    end

    def load_data
        @option_cases=Spree::OptionCase.order(:name)
    end

    def value_index_includes
        [
            value_images: [viewable: { option_values: :option_type }]
        ]
    end
end