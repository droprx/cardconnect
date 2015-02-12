module CardConnect
  module Service
    class CaptureResponse
      include Utils

      FIELDS = [:merchid, :account, :amount, :retref, :setlstat]

      attr_accessor *FIELDS

      # Settlement Statuses
      TXN_NOT_FOUND = 'Txn not found' # The Retref was not found
      AUTHORIZED = 'Authorized' # Auth only, not captured
      QUEUED = 'Queued for Capture' # Queued for the Processor
      ZERO_AMOUNT = 'Zero Amount' # Capture (and Auth) were Voided
      ACCEPTED = 'Accepted' # Accepted by the Processor
      REJECTED = 'Rejected' # Rejected by the Processor

      def initialize(response)
        set_attributes(response, FIELDS)
      end

      def body
        body = {}
        FIELDS.each do |attr|
          body.merge!({attr => send(attr)})
        end
        body
      end

    end
  end
end
