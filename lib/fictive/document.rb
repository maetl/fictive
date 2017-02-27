module Fictive
  class Document
    attr_reader :text

    def initialize(text)
      @text = text
      @parser = Syntax::Parser.new(@text)
    end

    def ensure_parsed_doc
      @doc = @parser.parse unless @doc
    end

    PARSER_STATE_DOC = 0
    PARSER_STATE_TEXT = 2

    def passages
      ensure_parsed_doc
      keyspace = {}
      @state = PARSER_STATE_DOC
      @current_id = nil

      @doc.children.each do |fragment|
        if @state == PARSER_STATE_DOC
          if fragment.type == :id
            @state = PARSER_STATE_TEXT
            @current_id = fragment.text
            keyspace[@current_id] = []
          else
            @state = PARSER_STATE_TEXT
            @current_id = rand
            keyspace[@current_id] = [fragment]
          end
        elsif @state == PARSER_STATE_TEXT
          if fragment.type == :id
            @current_id = fragment.text
          else
            keyspace[@current_id] << fragment
          end
        end
      end

      keyspace.values
    end
  end
end
