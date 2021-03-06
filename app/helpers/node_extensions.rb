# This module contains our custom syntax node classes. Each
# class represents a distinct type of entity. Each clas
# also has a distinct to_array method which allows the 
# final AST to be converted easily into a structured array
# representatiion



module Sexp
  
  class IntegerLiteral < Treetop::Runtime::SyntaxNode
    def to_array
      return self.text_value
    end
  end
  
  class StringLiteral < Treetop::Runtime::SyntaxNode
    def to_array
      return self.text_value
    end
  end
  
  class FloatLiteral < Treetop::Runtime::SyntaxNode
    def to_array
      return self.text_value
    end
  end
  
  class Identifier < Treetop::Runtime::SyntaxNode
    #extend Parser
    def to_array
      #item_period=  (Date.today<<1).beginning_of_month
      #@item_period= Praser.foo
        @item_period= @@date
        @inputset=Inputset.where( "name = ?", self.text_value)
        if @inputset == []
          return "Not Available"
        else
        @input=@inputset[0].inputs.where("period = ?", @item_period)
          if @input == []
            return "Not Available"
          else 
            return @input[0].value
          end
      end
    end
  end
  
  class Expression < Treetop::Runtime::SyntaxNode
    def to_array
      return self.elements[0].to_array
    end
  end
  
  class Body < Treetop::Runtime::SyntaxNode
    def to_array
      return self.elements.map {|x| x.to_array}
    end
  end
end