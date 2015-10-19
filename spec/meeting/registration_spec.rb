require 'spec_helper'

describe Webex::Meeting::Registration do
  api_url = 'https://engsound.webex.com/engsound/m.php'
  custom_attributes = { meeting_key: 'AutoStartFeature' }
  register_attributes = { first_name: "first_name", last_name: 'last_name', computer_name: 'computer_name', email_address: 'email', job_title: 'job_title'}

  context '[PARAMS]form' do
    api_type = 'GF'

    it '#api /m.php with custom set' do
      params = Webex::Meeting::Registration.new(custom_attributes).form
      
      expect(params['AT']).to eq api_type
      expect(params['ST']).to eq 'FAIL'
      expect(params['RS']).to eq 'InvalidDataFormat'
    end
  end

  context '[ERROR]form' do
    it '#api /m.php with option_missing' do
      expect { Webex::Meeting::Registration.new.form }.to raise_error(Webex::MissingOption)
    end
  end

  context '[PARAMS]register' do
    api_type = 'RM'

    it '#api /m.php with minimum set' do
      params = Webex::Meeting::Registration.new(custom_attributes.merge!(register_attributes)).register
      
      expect(params['AT']).to eq api_type
      expect(params['ST']).to eq 'FAIL'
      expect(params['RS']).to eq 'InvalidDataFormat'
    end

    it '#api /m.php with full set' do
      arrtributes = custom_attributes.merge!(register_attributes)
      name_and_values = [ {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'},
                          {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'},
                          {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'} ]
      text_box_contents = ['text1', 'text2', 213_14, 521_5, 521_5, 521_5]
      check_box_contents = ['check1', 'check2', 213_14, 521_5, 521_5]
      radio_button_contents = ['radio1', 'radio2', 123, 'lsfigwlov']
      dropdown_list_selections = ['dropdown_list_selection1', 'dropdown_list_selection2']

      params = Webex::Meeting::Registration.new(
        arrtributes.merge!(name_and_values: name_and_values,
                           text_box_contents: text_box_contents,
                           check_box_contents: check_box_contents,
                           radio_button_contents: radio_button_contents,
                           dropdown_list_selections: dropdown_list_selections
                          )
      ).register
      
      expect(params['AT']).to eq api_type
      expect(params['ST']).to eq 'FAIL'
      expect(params['RS']).to eq 'InvalidDataFormat'
    end
  end

  context '[ERROR]register' do[]
    it '#api /m.php with option_missing' do
      expect { Webex::Meeting::Registration.new.register }.to raise_error(Webex::MissingOption)
    end
    it '#api /m.php with length error' do
      arrtributes = custom_attributes.merge!(register_attributes)
      name_and_values = [ {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'},
                          {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'},
                          {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'},
                          {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'}, {name: 'name', value: 'value'} ]
      expect {
        Webex::Meeting::Registration.new(
          arrtributes.merge!(name_and_values: name_and_values)
        ).register
      }.to raise_error(Webex::LengthError)
    end
  end
end
