require "spec_helper"

describe UpdateContactNote do

  let!(:note) {Note.create(user_id: 1, box_id: 1, notes: "note")}

  it "fails when no note hash is passed" do
    result = UpdateContactNote.run({})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:no_note_info_passed)
  end

  it "fails when the note id is invalid" do
    result = UpdateContactNote.run({note: {id: 1000}})
    expect(result.success?).to eq(false)
    expect(result.error).to eq(:invalid_note_id)
  end

  it "updates a note based on note id" do
    result = UpdateContactNote.run({note: {id: note.id, notes: "update"}})
    expect(result.success?).to eq(true)
    expect(result.note.notes).to eq("update")
    expect(result.note.user_id).to eq(1)
    expect(result.note.box_id).to eq(1)
  end

  it "raises exception when extraneous information is passed" do
    expect {UpdateContactNote.run({
      note: {id: note.id, notes: "update", foo: "bar"}})}.to raise_error
  end
end
