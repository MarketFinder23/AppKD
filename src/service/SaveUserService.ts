import { Body, Injectable } from '@nestjs/common';
//import { usuario } from 'src/model/Usuario';

export interface UserInfo {
  fk_endereco: any;
  telefone: any;
  nome: any;
  senha: any;
  email: any;
  plano: any;
}
//fazer validação se o usuario ja foi cadastrado
@Injectable()
export class SaveUserService {
  async saveUser(@Body() body: any): Promise<any> {
    const { email, password } = body;

    console.log('Deu boa');

    if (email == 'nome@mail.com' && password == 'senha123') {
      return { authorized: true };
    } else {
      return { authorized: false };
    }
    // try {
    //   // Crie um novo registro na tabela de usuários
    //   const newUser = await usuario.create({
    //     fk_endereco: userInfo.fk_endereco,
    //     telefone: userInfo.telefone,
    //     nome: userInfo.nome,
    //     senha: userInfo.senha,
    //     email: userInfo.email,
    //     plano: userInfo.plano,
    //   });
    //   // Retorna o novo usuário criado
    //   return newUser;
    // } catch (error) {
    //   // Lidar com erros
    //   console.error('Erro ao salvar usuário:', error);
    //   throw new Error('Erro ao salvar usuário');
    // }
  }
}
