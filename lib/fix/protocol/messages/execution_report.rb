module Fix
  module Protocol
    module Messages
      #
      # A FIX execution report
      #
      class ExecutionReport < FP::Message

        EXECUTION_TYPES = {
          new: '0',
          partial_fill: '1',
          filled: '2',
          done_for_day: '3',
          canceled: '4',
          replace: '5',
          pending_cancel: '6',
          stopped: '7',
          rejected: '8',
          suspended: '9',
          pending_new: 'A',
          calculated: 'B',
          expired: 'C',
          restated: 'D',
          pending_replace: 'E'
        }

        ORDER_STATUSES = {
          new: '0',
          partially_filled: '1',
          filled: '2',
          done_for_day: '3',
          canceled: '4',
          replaced: '5',
          pending_cancel: '6',
          stopped: '7',
          rejected: '8',
          suspended: '9',
          pending_new: 'A',
          calculated: 'B',
          accepted_for_bidding: 'C',
          restated: 'D',
          pending_replace: 'E'
        }

        TRANSACTION_TYPES = {
          new: '0',
          cancel: '1',
          correct: '2',
          status: '3'
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
