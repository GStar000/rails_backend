module Spree
    OptionValue.class_eval do
        has_attached_file :image, styles: { large: "600*600>", medium: "300*300>", thumb: "150*150#" }
        validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
    end
end
