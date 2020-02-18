describe PermissionSearchFilters do
 
  describe "#present?"do
    subject do
      PermissionSearchFilters.new(filters).present?
    end

    context "give no filters are provided" do
      let(:filters) do
        {}
      end

      it { should be false }
    end

    context "given name filter is provided" do
      let(:filters) do
        { name: "aname" }
      end

      it { should be true }
    end

    context "given resource filter is provided" do
      let(:filters) do
        { resource: "aresource" }
      end

      it { should be true }
    end

    context "given action filter is provided" do
      let(:filters) do
        { action: "anaction" }
      end

      it { should be true }
    end
  end

  describe "#apply" do
    before do
      create(:permission, name: "DoEverything", resource: "AllOfThem", action: "all")
      create(:permission, name: "WriteCode", resource: "Project", action: "code")
    end
    let(:result) do
      PermissionSearchFilters.new(filters).apply
    end

    context "given name filter as been provided" do
      let(:filters) do
        { name: "every" }
      end

      it "should apply the name filter" do
        expect(result.size).to eq 1
        expect(result.first.name).to eq "DoEverything"
      end
    end

    context "given resource filter has been provided" do
      let(:filters) do
        { resource: "of" }
      end

      it "should apply the resource filter" do
        expect(result.size).to eq 1
        expect(result.first.resource).to eq "AllOfThem"
      end
    end

    context "given action filter has been provided" do
      let(:filters) do
        { action: "od" }
      end

      it "should apply the action filter" do
        expect(result.size).to eq 1
        expect(result.first.action).to eq "code"
      end
    end

    context "given all filters have been provided" do
      let(:filters) do
        { name: "doeverything", resource: "allofthem", action: "none" }
      end

      it "should apply all filters" do
        expect(result).to be_empty
      end
    end

    context "given no filters have been provided" do
      let(:filters) do
        {}
      end

      it "should return everything" do
        expect(result.size).to eq 2
      end
    end
  end
end
