describe ApplicationHelper do

  describe "#display_error_class_for" do
    before do
      subject.validate
    end

    context "when specified model property has error" do
      subject do
        build :permission, name: nil
      end

      it "returns 'has-error'" do
        expect(display_error_class_for(subject, :name)).to eq "has-error"
      end
    end

    context "when specified model property has no error" do
      subject do
        build :permission
      end

      it "returns nil" do
        expect(display_error_class_for(subject, :name)).to be_nil
      end
    end
  end

  describe "#edit_link_class_for" do
    subject do
      create :permission
    end

    it "should return `edit-model-id`" do
      expect(edit_link_class_for(subject)).to eq "edit-#{subject.class.name.downcase}-#{subject.id}"
    end
  end
end
