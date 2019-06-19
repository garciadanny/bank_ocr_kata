module DocumentHelper
  def fixtures_path
    File.join(File.dirname(__FILE__), '../', 'fixtures/')
  end

  def document_path(document_name)
    File.join(fixtures_path, document_name)
  end
end
