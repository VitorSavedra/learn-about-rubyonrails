class ProdutosController < ApplicationController

    before_action :set_produto, only: [:edit, :update,:destroy]

    def index
        @produtos_por_nome = Produto.all.order(:nome).limit(5)
        @produtos_por_preco = Produto.all.order(:preco).limit(2)
    end

    def create
        produto_params
        @produto = Produto.new produto_params
        if @produto.save
            flash[:notice] = "Produto salvo com sucesso."
            redirect_to root_url
        else
            renderiza :new
        end
    end

    def destroy
        @produto.destroy
        redirect_to root_url
    end

    def busca
        @buscar = params[:nome]
        @produtos = Produto.where "nome like ?", "%#{@buscar}%"    
    end

    def new
        @produto = Produto.new
        renderiza :new
    end

    def edit
        renderiza :edit
    end

    def update
        if @produto.update produto_params
            flash[:notice] = "Produto alterado com sucesso."
            redirect_to root_url
        else
            renderiza :edit
        end
    end

    # Private methods.
    private
    def renderiza(view)
        @departamentos = Departamento.all
        render view
    end

    def set_produto
        id = params[:id]
        @produto = Produto.find(id)
    end

    def produto_params
        valores = params.require(:produto).permit :nome, :preco, :descricao, :quantidade, :departamento_id
    end
end