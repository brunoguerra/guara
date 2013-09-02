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
      it { should respond_to(:ignored) }

      it { should respond_to(:expired_contacts) }

      it { should respond_to(:find_or_create_deal) }

      its(:to_contact) { should have(list_customer_pjs.size).items }

      context "#find_or_create_deal" do

        it "creates deal when no one to customer and group" do
          expect{ group.find_or_create_deal(customer_pj.person) }.to change{ Scheduled::Deal.count }.by(1)
        end

        it "finds a deal to customer and group" do
          group.find_or_create_deal(customer_pj.person) # first call just create one
          expect{ group.find_or_create_deal(customer_pj.person) }.to change{ Scheduled::Deal.count }.by(0)
        end
      end

      # ##
      # ###
      let (:deal)                   { group.find_or_create_deal(list_customer_pjs.first.person)}
      let (:contacted_customer)     { Factory :scheduled_contact, deal: deal }
      let (:ids_not_contacted)      { list_customer_pj_ids - [contacted_customer.deal.customer_id] }
      let(:ids_to_contact_on_group) { group.to_contact.all.collect {|p| p.id } }

      context "#to_contact" do
        it 'removes contacteds customers from #to_contact list' do
          ids_not_contacted.each { |id| ids_to_contact_on_group.should include(id) }
          expect(ids_to_contact_on_group).to_not include contacted_customer.deal.customer.id
        end

        it { expect(list_customer_pjs.size).to eq(group.count_schedule) }
      end

      context "#scheduled_contacts" do
        before { group.save! }

        #given
        let (:people_scheduled) do 
          (1..2).collect {
              Factory :scheduled_contact,
                      deal: deal,
                      result: Scheduled::Contact::SCHEDULED,
                      scheduled_at: Date.today + 2.days
          }
        end
        let (:ids_scheduleds) { people_scheduled.collect {|c| c.deal.customer.id }}
        let (:ids_of_people_scheduled_on_group) { group.contacts.all.collect {|p| p.deal.customer.id } }

        #expect
        its(:contacts) { should have(people_scheduled.size).items }

        it 'lists scheduled contacts' do  
          ids_scheduleds.each { |id| ids_of_people_scheduled_on_group.should include id }
        end

        it { expect(people_scheduled.size).to be(group.count_scheduled) }
      end

      context "#expired_contacts" do
        let (:expired_contact)     { Factory :scheduled_contact, deal: deal, scheduled_at: 1.day.ago, result: Scheduled::Contact::SCHEDULED_REALIZED }
        before { Scheduled::Contact.update_all("result = #{Scheduled::Contact::SCHEDULED}", {id: expired_contact.id}) }

        it { group.expired_contacts.should include(expired_contact) }
      end

      context "#ignoreds" do
        let(:ignored) do
          FactoryGirl.build(
            :scheduled_ignored, 
            customer_id: list_customer_pjs.first.person.id,
            group_id: group.id
          )
        end

        before { group.save }

        it { expect{ ignored.save! }.to change { group.ignored.count }.from(0).to(1) }
        it { expect{ ignored.save! }.to change { group.to_contact.count }.from(list_customer_pjs.size).to(1) }

      end
    end
  end
end
