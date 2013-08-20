require 'spec_helper'

module Guara
  module ActiveCrm
    describe Scheduled::Group do

      let(:scheduled)                       { Factory(:scheduled) }
      let(:customer_pj)                     { Factory(:customer_pj) }
      let(:list_customer_pjs)               { (1..2).collect { Factory(:customer_pj) } }
      let(:list_customer_pj_ids)            { list_customer_pjs.collect{|c_pj| c_pj.person.id } }

      subject(:group) { Scheduled::Group.new(scheduled: scheduled, employes_min: 10) } 

      it { should respond_to(:to_contact) }
      it { should respond_to(:scheduled) }
      it { should respond_to(:deals) }

      its(:to_contact) { should have(list_customer_pjs.size).items }

      let (:contacted_customer)     { Factory :scheduled_contact, person: list_customer_pjs.first.person, scheduled: group.scheduled, group: group }
      let (:ids_not_contacted)      { list_customer_pj_ids - [contacted_customer.person_id] }
      let(:ids_to_contact_on_group) { group.to_contact.all.collect {|p| p.id } }

      context "#to_contact" do
        it 'removes contacteds customers from #to_contact list' do
          ids_not_contacted.each { |id| ids_to_contact_on_group.should include(id) }
          expect(ids_to_contact_on_group).to_not include contacted_customer.person_id
        end

        it { expect(list_customer_pjs.size).to eq(group.count_schedule) }
      end

      context "#scheduled_contacts" do
        before { group.save! }

        #given
        let (:people_scheduled) do 
          (1..2).collect {
              Factory :scheduled_contact,
                      person: Factory(:customer_pj).person,
                      group: group,
                      result: Scheduled::Contact::SCHEDULED,
                      scheduled_at: Date.today + 2.days
          }
        end
        let (:ids_scheduleds) { people_scheduled.collect {|c| c.person.id }}
        let (:ids_of_people_scheduled_on_group) { group.scheduled_contacts.all.collect {|p| p.person_id } }

        #expect
        its(:scheduled_contacts) { should have(people_scheduled.size).items }

        it 'lists scheduled contacts' do  
          ids_scheduleds.each { |id| ids_of_people_scheduled_on_group.should include id }
        end

        it { expect(people_scheduled.size).to be(group.count_scheduled) }
      end
    end
  end
end
