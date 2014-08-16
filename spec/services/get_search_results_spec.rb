require 'spec_helper'

describe 'GetSearchResults' do
  let(:query_params) {Hash.new}
  let(:result) {GetSearchResults.run(query_params)}

  it "errors out when there is no query" do
    query_params = {query: ""}
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:no_query_given)
  end

  context "query is there" do
    before do
      query_params[:query] = "KEYWORD"
    end


    context "there is no data in the db" do
      it "returns a hash" do
        expect(result.success?).to eq(true)
        expect(result.search_results).to be_a(Hash)
        expect(result.search_results[:pipelines]).to eq([])
        expect(result.search_results[:stages]).to eq([])
        expect(result.search_results[:pipelines_by_field]).to eq([])
        expect(result.search_results[:contacts]).to eq([])
        expect(result.search_results[:boxes]).to eq([])
      end
    end


    context "there is data in the database" do
      let!(:pipeline1) {Pipeline.create(name: "KEYWORD")}
      let!(:pipeline2) {Pipeline.create(name: "Not me")}
      let!(:pipeline3) {Pipeline.create(name: "Not this one here")}
      let!(:stage1) {Stage.create(name: "Whatever")}
      let!(:stage2) {Stage.create(name: "KEYWORD")}
      let!(:stage3) {Stage.create(name: "KEYWORD")}
      let!(:field1) {pipeline1.fields.create(field_name: "haha")}
      let!(:field2) {pipeline1.fields.create(field_name: "lawl")}
      let!(:field3) {pipeline2.fields.create(field_name: "KEYWORD")}
      let!(:field4) {pipeline3.fields.create(field_name: "fill this")}
      let!(:field5) {pipeline3.fields.create(field_name: "fill that")}
      let!(:contact1) {Contact.create(name: "KEYWORD")}
      let!(:contact2) {Contact.create(name: "Jo")}
      let!(:contact3) {Contact.create(name: "Shmo", email: "KEYWORD")}
      let!(:contact4) {Contact.create(name: "Lo")}
      let!(:contact5) {Contact.create(name: "Bo")}
      let!(:contact6) {Contact.create(name: "Dunno")}
      let!(:box1) {Box.create(contact_id: contact1.id, pipeline_id: pipeline1.id)}
      let!(:box2) {Box.create(contact_id: contact1.id, pipeline_id: pipeline2.id)}
      let!(:box3) {Box.create(contact_id: contact2.id, pipeline_id: pipeline3.id)}
      let!(:box4) {Box.create(contact_id: contact3.id, pipeline_id: pipeline2.id)}
      let!(:box_unused) {Box.create(contact_id: contact6.id, pipeline_id: pipeline3.id)}
      let!(:box_field1) {BoxField.create(box_id: box1.id, field_id: field1.id, value: "KEYWORD")}
      let!(:box_field2) {BoxField.create(box_id: box1.id, field_id: field2.id, value: "KEYWORD")}
      let!(:box_field3) {BoxField.create(box_id: box2.id, field_id: field3.id, value: "KEYWORD")}
      let!(:box_field_unused) {BoxField.create(box_id: box_unused.id, field_id: field5.id, value: "Useless")}


      it "returns matching pipelines" do
        expect(result.success?).to eq(true)
        pipelines = result.search_results[:pipelines]
        expect(pipelines).to_not be_nil
        expect(pipelines.size).to eq(1)
        expect(pipelines[0].id).to eq(pipeline1.id)
        expect(pipelines[0].name).to eq(pipeline1.name)
      end

      it "returns matching stages" do
        expect(result.success?).to eq(true)
        stages = result.search_results[:stages]
        expect(stages).to_not be_nil
        expect(stages.size).to eq(2)
        expect(stages[0].id).to eq(stage2.id)
        expect(stages[0].name).to eq(stage2.name)
        expect(stages[1].id).to eq(stage3.id)
      end

      it "returns pipelines with matching field names" do
        pipelines = result.search_results[:pipelines_by_field]
        # binding.pry
        expect(pipelines.length).to eq(1)
        expect(pipelines[0].id).to eq(pipeline2.id)
      end
        
      it "returns contacts with matching names" do
        contacts = result.search_results[:contacts]
        expect(contacts.length).to eq(2)
        expect(contacts[0].id).to eq(contact1.id)
        expect(contacts[1].id).to eq(contact3.id)
      end

      it "returns boxes with matching field values" do
        # Minimum data necessary
        #   field.field_name and box_field.value for the text
        #   contact.name and pipeline.name are important to have too
        #   box.contact_id and box.pipeline_id for url
        boxes = result.search_results[:boxes]
        # Box 1 and Box 2 should be in it
        expect(boxes.size).to eq(3)
        expect(boxes[0][:contact].id).to eq(box1.contact_id)
        expect(boxes[0][:pipeline].id).to eq(box1.pipeline_id)
        expect(boxes[0][:pipeline].name).to eq(pipeline1.name)
        expect(boxes[0][:contact].name).to eq(contact1.name)
        expect(boxes[0][:field][:field_name]).to eq(field1.field_name)
        expect(boxes[0][:field][:value]).to eq("KEYWORD")

        expect(boxes[1][:contact].id).to eq(box1.contact_id)
        expect(boxes[1][:pipeline].id).to eq(box1.pipeline_id)
        expect(boxes[1][:pipeline].name).to eq(pipeline1.name)
        expect(boxes[1][:contact].name).to eq(contact1.name)
        expect(boxes[1][:field][:field_name]).to eq(field2.field_name)
        expect(boxes[1][:field][:value]).to eq("KEYWORD")

        expect(boxes[2][:contact].id).to eq(box2.contact_id)
        expect(boxes[2][:pipeline].id).to eq(box2.pipeline_id)
        expect(boxes[2][:pipeline].name).to eq(pipeline2.name)
        expect(boxes[2][:contact].name).to eq(contact1.name)
        expect(boxes[2][:field][:field_name]).to eq(field3.field_name)
        expect(boxes[2][:field][:value]).to eq("KEYWORD")
      end
    end
  end
end