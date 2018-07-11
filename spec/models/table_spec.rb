require 'rails_helper'

RSpec.describe Table, type: :model do
  describe ".select_smallest_available" do
    let(:party_size) { 6 }
    let(:start) { Time.now }
    let(:end_time) { start + 3.hours }

    subject { described_class.select_smallest_available(party_size: party_size, start: start, end_time: end_time) }

    context "when a free table exists with enough capacity" do
      let!(:free_table) { Table.create!(seats: party_size, name: "a nice table") }

      it "returns the free table" do
        expect(subject).to eq(free_table)
      end
    end

    context "when there's a free table but it's too small" do
      before { Table.create!(seats: party_size - 1, name: "a wee table") }

      it "returns nil" do
        expect(subject).to be nil
      end
    end

    context "given multiple free tables with enough capacity" do
      before do
        Table.create!(seats: party_size + 1, name: "bigger table")
        Table.create!(seats: party_size, name: "just-right table")
        Table.create!(seats: party_size + 2, name: "biggerer table")
        Table.create!(seats: party_size + 3, name: "biggest table")
      end

      it "picks the smallest one" do
        expect(subject.seats).to eq(party_size)
        expect(subject.name).to eq("just-right table")
      end
    end

    context "when the table already has a reservation" do
      before do
        table = Table.create!(name: "reserved table", seats: party_size)
        Reservation.create!(
          table: table,
          party_size: party_size,
          start: start,
          end_time: end_time,
          email: "foo@bar.com"
        )
      end

      it "returns nil" do
        expect(subject).to be nil
      end
    end
  end
end
