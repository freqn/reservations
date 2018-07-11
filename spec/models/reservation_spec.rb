require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "email validation" do
    let(:email) { "test@example.com" }

    subject do
      Reservation.new(email: email).tap {|r| r.valid?}
    end

    context "with a valid email address" do
      it "the email field is valid" do
        expect(subject.errors.keys).not_to include(:email)
      end
    end

    context "with a bogus email address" do
      let(:email) { "bananas" }

      it "the email field is invalid" do
        expect(subject.errors.keys).to include(:email)
      end
    end

    context "with a missing email address" do
      let(:email) { nil }

      it "the email field is invalid" do
        expect(subject.errors.keys).to include(:email)
      end
    end
  end
end
