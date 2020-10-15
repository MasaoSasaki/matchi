require 'rails_helper'

RSpec.describe Reservation, type: :model do

  describe 'Reservationモデルのテスト' do
    context '保存ができる場合のテスト' do
      it '保存ができる' do
        reservation = build(:reservation)
        expect(reservation).to be_valid
      end
    end
    context '保存ができない場合のテスト' do
      it '外部キーが空白の場合は保存できない' do
        reservation = build(:reservation, user_id: nil)
        expect(reservation).to be_invalid
        reservation = build(:reservation, menu_id: nil)
        expect(reservation).to be_invalid
      end
      it ':reservation_yearが空白の場合は保存できない' do
        reservation = build(:reservation, reservation_year: nil)
        expect(reservation).to be_invalid
      end
      it ':reservation_yearが文字列型の場合は保存できない' do
        reservation = build(:reservation, reservation_year: '２０２０')
        expect(reservation).to be_invalid
      end
      it ':reservation_monthが空白の場合は保存できない' do
        reservation = build(:reservation, reservation_month: nil)
        expect(reservation).to be_invalid
      end
      it ':reservation_monthが2桁を場合は保存できない' do
        reservation = build(:reservation, reservation_month: '１００')
        expect(reservation).to be_invalid
      end
      it ':reservation_dayが空白の場合は保存できない' do
        reservation = build(:reservation, reservation_day: nil)
        expect(reservation).to be_invalid
      end
      it ':reservation_dayが2桁を場合は保存できない' do
        reservation = build(:reservation, reservation_day: '１００')
        expect(reservation).to be_invalid
      end
      it ':reservation_timeが空白の場合は保存できない' do
        reservation = build(:reservation, reservation_time: nil)
        expect(reservation).to be_invalid
      end
      it ':reservation_timeが2桁を場合は保存できない' do
        reservation = build(:reservation, reservation_time: '１００')
        expect(reservation).to be_invalid
      end
      it ':peopleが空白の場合は保存できない' do
        reservation = build(:reservation, people: nil)
        expect(reservation).to be_invalid
      end
      it ':peopleが文字列型の場合は保存できない' do
        reservation = build(:reservation, people: '２')
        expect(reservation).to be_invalid
      end
      it ':reservation_statusが空白の場合は保存できない' do
        reservation = build(:reservation, reservation_status: nil)
        expect(reservation).to be_invalid
      end
      it ':reservation_statusが文字列型の場合は保存できない' do
        reservation = build(:reservation, reservation_status: '０')
        expect(reservation).to be_invalid
      end
    end
  end

end
