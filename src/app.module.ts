import { Module } from '@nestjs/common';
//import { ConfigModule } from '@nestjs/config';

//import { SequelizeModule } from '@nestjs/sequelize';
// import { usuario } from './model/Usuario';
// import { endereco } from './model/Endereco';
// import { imagens } from './model/Imagens';
// import { item_carrinho } from './model/ItemCarrinho';
// import { loja } from './model/Loja';
// import { produto } from './model/Produto';
// import { carrinho_user } from './model/CarrinhoUser';
import { UserController } from './controller/UserController';
import { ListUserService } from './service/ListUserService';
import { SaveUserService } from './service/SaveUserService';

@Module({
  imports: [
    //ConfigModule.forRoot(), // Carrega as variáveis de ambiente do arquivo .env
    // SequelizeModule.forRoot({
    //   dialect: 'postgres', // Escolha o dialeto do banco de dados que você está usando
    //   host: process.env.POSTGRES_HOST,
    //   port: parseInt(process.env.POSTGRES_PORT, 10),
    //   username: process.env.POSTGRES_USER,
    //   password: process.env.POSTGRES_PASSWORD,
    //   database: process.env.POSTGRES_DATABASE,
    //   autoLoadModels: true, // Isso carregará automaticamente os modelos Sequelize do diretório 'models'
    //   synchronize: true, // Isso sincronizará automaticamente os modelos com o banco de dados (apenas para ambiente de desenvolvimento!)
    // }),
    // SequelizeModule.forFeature([
    //   usuario,
    //   carrinho_user,
    //   endereco,
    //   imagens,
    //   item_carrinho,
    //   loja,
    //   produto,
    // ]), // Passe todos os modelos que deseja usar no array
  ],
  controllers: [UserController], // Adicione todos os controladores relacionados a este módulo
  providers: [ListUserService, SaveUserService], // Adicione todos os provedores (serviços) relacionados a este módulo
})
export class AppModule {}
