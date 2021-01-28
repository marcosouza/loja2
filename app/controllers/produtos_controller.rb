class ProdutosController < ApplicationController

    def index 
        @produtos = Produto.order(nome: :asc).limit 8
        @produto_com_desconto = Produto.order(:preco).limit 3
    end 

    def new
        @produto = Produto.new
        @departamentos = Departamento.all 
    end    

    def edit
        id = params[:id]
        @produto = Produto.find(id)
        @departamento = Departamento.all
        render :new
    end
    
    def update
        id = params[:id]
        @produto = Produto.find(id)
        valores = params.require(:produto).permit(:nome, :descricao, :preco,
        :quantidade, :departamento_id)
        if produto.update valores
            flash[:notice] = "produto atualizado com sucesso!"
            redirect_to root_url
        else 
            @departamento = Departamento.all
            render :new  
        end
    end         
    
    def create
        valores = params.require(:produto).permit(:nome, :descricao, :preco,
         :quantidade, :departamento_id)
        @produto = Produto.new valores
        if @produto.save
            redirect_to root_url
            flash[:notice] = "produto salvo com sucesso!"
        else 
            render :new
        end       
    end
            
    def destroy
        id = params[:id]
        Produto.destroy id
        redirect_to root_url
    end   
    
    def busca
        @nome = params[:nome]
        @produtos = Produto.where "nome like ?", "%#{@nome}%"
    end

end
