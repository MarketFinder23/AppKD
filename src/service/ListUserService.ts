import { Injectable } from '@nestjs/common';
//import { usuario } from 'src/model/Usuario';

@Injectable()
export class ListUserService {
  async getUser() {
    // Marcando o método como assíncrono e definindo o tipo de retorno como Promise<any[]>
    try {
      // const users = await usuario.findAll(); // Usando await dentro de um método assíncrono
      // return users;
      console.log('DEU BOA');
      return true;
    } catch (error) {
      console.error('Erro ao buscar o usuário', error);
      //throw new Error('Erro ao obter usuários');
      return false;
    }
  }
}
