class AdminController < ApplicationController
  respond_to :html, :json

  def generate_part_of_code(size = 4)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end

  def generate_full_code(parts = 4)
    (1..parts.to_i).map do |i|
      if i != parts.to_i
        generate_part_of_code+"-"
      else
        generate_part_of_code
      end
    end.join
  end

  def create_type(type)
    record = Type.new
    record.name = type
    record.save
  end

  def create_present(type, type_id, uniq_code,ttl)
    record = Present.new()
    record.name = type
    record.types_id = type_id
    record.code = uniq_code
    record.ttl = ttl
    record.save
  end

  def get_type_id()
    return Type.last[:id]
  end

  def create_rules_for_types(type_id, rule_id, value, stackcounter)
    record = RulesForType.new
    record.types_id = type_id
    record.rules_id = rule_id
    record.value = value
    record.stackcounter = stackcounter
    record.save
  end

  def index
    @rules = Rule.all
  end

  def create
    rules_arr  = {}
    values_arr = {}
    stacks_arr = {}
    @codes     = []

    type = params[:type]
    amount = params[:amount]
    amount = 1 if amount == ""

    ttl = params[:ttl]
    ttl = 1 if ttl == ""

    created_type = 0
  
    if type != ""
      params.each do |key, value|
        if(key.to_s[/rule.*/])
          rules_arr[key] = value
        elsif(key.to_s[/value.*/])
          if value==""
            @message = "Please fill in all fields. You have skipped Value"
          else
            values_arr[key] = value
          end
        elsif(key.to_s[/stack.*/])
          if value==""
            value = 1
          else
            stacks_arr[key] = value
          end
        end
      end
      if rules_arr.count < 1 || (values_arr.count != rules_arr.count)
        @message = "Please fill in all fields. You have skipped Value or broke database"
      end
    else
      @message = "Please fill in all fields. You have skipped Description"
    end
    (1..amount.to_i).each do |i|
      if created_type == 0
        create_type(type)
        type_id = get_type_id()
        rules_arr.each do |r_key, r_value|
          values_arr.each do |v_key, v_value|
            stacks_arr.each do |s_key, s_value|
              create_rules_for_types(type_id, r_value, v_value, s_value)
            end
          end
        end
      end
      created_type = 1
      uniq_code = generate_full_code()
      create_present(type, type_id, uniq_code,ttl)
      @codes << uniq_code
    end
  end

end