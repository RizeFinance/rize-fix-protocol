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
          field :exec_trans_type, tag: 20,  mapping: TRANSACTION_TYPES
          field :order_status,    tag: 39,  mapping: ORDER_STATUSES
          field :exec_type,       tag: 150, mapping: EXECUTION_TYPES
        end

        def errors
          errs = []
          [super, errs].flatten
        end

      end
    end
  end
end
