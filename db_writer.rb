require 'neo4j-core'
require 'neo4j/core/cypher_session/adaptors/http'

class DbWriter
  DEFAULT_N = 10_000
  DEFAULT_URL = "http://localhost:7474"

  attr_reader :n, :url

  def initialize(n = DEFAULT_N, url = DEFAULT_URL)
    @n = n
    @url = url
  end

  def run
    n.times do |i|
      run_tx i

      if (i % 5000) == 0
        puts `./backup.sh`
      end

      if ((i-500) % 5000) == 0
        puts `./list_db_txs.sh`
        puts `./list_backup_txs.sh`
      end

    end
  end

  private

  def run_tx(i)
    puts "i: #{i}" if (i % 100) == 0
    session.query build_cypher(i)
  end

  def build_cypher(i)
    <<-CYPHER
    MERGE (n:Number { val: #{i}})
    MERGE (last:Number { val: #{i-1}})
    MERGE (n)-[:PREV]->(last)
    MERGE (last)-[:NEXT]->(n)
    CYPHER
  end

  def session
    @_session ||= Neo4j::Core::CypherSession.new(http_adaptor)
  end

  def http_adaptor
    @_http_adatpr ||= Neo4j::Core::CypherSession::Adaptors::HTTP.new(url)
  end
end

writer = DbWriter.new 10_000_000

writer.run
