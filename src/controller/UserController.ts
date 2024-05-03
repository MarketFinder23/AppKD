import { Body, Controller, Get, Post } from '@nestjs/common';
import { ListUserService } from 'src/service/ListUserService';
import { SaveUserService } from 'src/service/SaveUserService';

@Controller('users')
export class UserController {
  constructor(
    private readonly saveUserService: SaveUserService,
    private readonly listUserService: ListUserService,
  ) {}

  @Get()
  async getUser(): Promise<any> {
    try {
      //const result = await this.listUserService.getUser();
      console.log('Result: ');
      return false;
    } catch (error) {
      console.error('Erro ao buscar o usuário', error);
      return false;
    }
  }

  @Post()
  async login(@Body() body: any): Promise<any> {
    console.log(body);
    return this.saveUserService.saveUser(body); // Encaminhe os dados de login para o serviço que os processará
  }
}
