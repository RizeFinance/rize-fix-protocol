module Fix
  module Protocol
    module Messages
      #
      # A FIX new order single message
      #
      class NewOrderSingle < FP::Message

        HANDLE_INSTRUCTIONS = {
          auto_private: 1, # Automated execution order, private, no Broker intervention
          auto_public:  2, # Automated execution order, public, Broker intervention OK
          manual:       3  # Manual order, best execution
        }

        ID_SOURCES = {
          cusip:       1,
          sedol:       2,
          quik:        3,
          isin_number: 4,
          ric_code:    5
        }

        IN_FORCE_TIMES = {
          day: 0, # Day order, default
          gtc: 1, # Good unTil Cancel
          opg: 2, # At the opening
          ioc: 3, # Immediate or cancel
          fok: 4, # Fill or kill
          gtx: 5, # Good unTil crossing
          gtd: 6  # Good unTil date
        }

        ORDER_TYPES = {
          market: '1',
          limit: '2',
          stop: '3',
          stop_limit: '4',
          market_on_close: '5',
          with_or_without: '6',
          limit_or_better: '7',
          limit_with_or_without: '8',
          on_basis: '9',
          on_close: 'A',
          limit_on_close: 'B',
          forex_market: 'C',
          previously_quoted: 'D',
          previously_indicated: 'E',
          forex_limit: 'F',
          forex_swap: 'G',
          forex_previously_quoted: 'H',
          funari: 'I',
          pegged: 'P'
        }

        RULES_80 = {
          agency_single_order: 'A'
        }

        SETTLEMENT_TYPES = {
          regular: '0',
          cash: '1',
          next_day: '2'
        }

        SIDES = {
          buy: 1,
          sell: 2
        }

        unordered :body do
          field :cl_ord_id,         tag: 11,  required: true
          field :handl_inst,        tag: 21,  required: true, type: :integer, mapping: HANDLE_INSTRUCTIONS
          field :ord_type,          tag: 40,  required: true, mapping: ORDER_TYPES
          field :symbol,            tag: 55,  required: true
          field :side,              tag: 54,  required: true, type: :integer, mapping: SIDES
          field :transact_time,     tag: 60,  required: true, type: :timestamp, default: proc { Time.now }
          field :account,           tag: 1
          field :currency,          tag: 15
          field :id_source,         tag: 22,  type: :integer, mapping: ID_SOURCES
          field :order_qty,         tag: 38,  type: :float
          field :price,             tag: 44,  type: :float
          field :rule_80_a,         tag: 47,  mapping: RULES_80
          field :security_id,       tag: 48
          field :text,              tag: 58
          field :time_in_force,     tag: 59,  type: :integer, mapping: IN_FORCE_TIMES
          field :settlmnt_typ,      tag: 63,  mapping: SETTLEMENT_TYPES
          field :min_qty,           tag: 110, type: :float
          field :max_floor,         tag: 111, type: :float
          field :security_type,     tag: 167
          field :security_exchange, tag: 207
          field :compliance_id,     tag: 376
          field :clearing_account,  tag: 440
        end

        def errors
          errs = []
          [super, errs].flatten
        end

      end
    end
  end
end
