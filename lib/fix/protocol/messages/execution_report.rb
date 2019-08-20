module Fix
  module Protocol
    module Messages
      #
      # A FIX execution report
      #
      class ExecutionReport < FP::Message

        EXECUTION_TYPES = {
          '0' => :new,
          '1' => :partial_fill,
          '2' => :filled,
          '3' => :done_for_day,
          '4' => :canceled,
          '5' => :replace,
          '6' => :pending_cancel,
          '7' => :stopped,
          '8' => :rejected,
          '9' => :suspended,
          'A' => :pending_new,
          'B' => :calculated,
          'C' => :expired,
          'D' => :restated,
          'E' => :pending_replace,
        }

        ORDER_STATUSES = {
          '0' => :new,
          '1' => :partially_filled,
          '2' => :filled,
          '3' => :done_for_day,
          '4' => :canceled,
          '5' => :replaced,
          '6' => :pending_cancel,
          '7' => :stopped,
          '8' => :rejected,
          '9' => :suspended,
          'A' => :pending_new,
          'B' => :calculated,
          'C' => :expired,
          'D' => :accepted_for_bidding,
          'E' => :pending_replace,
        }

        TRANSACTION_TYPES = {
          '0' => :new,
          '1' => :cancel,
          '2' => :correct,
          '3' => :Status
        }


        unordered :body do
          field :avg_px,          tag: 6,   type: :float
          field :cl_ord_id,       tag: 11,  required: true
          field :cum_qty,         tag: 14,  type: :float
          field :exec_id,         tag: 17
          field :exec_trans_type, tag: 20,  mapping: TRANSACTION_TYPES
          field :last_mkt,        tag: 30
          field :last_px,         tag: 31,  type: :float
          field :last_shares,     tag: 32,  type: :float
          field :order_id,        tag: 37
          field :order_qty,       tag: 38,  type: :float
          field :order_status,    tag: 39,  mapping: ORDER_STATUSES
          field :symbol,          tag: 55
          field :transact_time,   tag: 60,  type: :timestamp
          field :exec_type,       tag: 150, mapping: EXECUTION_TYPES
          field :leaves_qty,      tag: 151, type: :float
        end

        def errors
          errs = []
          [super, errs].flatten
        end

      end
    end
  end
end
