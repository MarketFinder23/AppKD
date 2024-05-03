import { Test, TestingModule } from '@nestjs/testing';
import { UserController } from './UserController';
import { ListUserService } from 'src/service/ListUserService';

describe('AppController', () => {
  let userController: UserController;

  beforeEach(async () => {
    const app: TestingModule = await Test.createTestingModule({
      controllers: [UserController],
      providers: [ListUserService],
    }).compile();

    userController = app.get<UserController>(UserController);
  });

  describe('root', () => {
    it('should return "Hello World!"', () => {
      expect(userController.getUser()).toBe('Hello World!');
    });
  });
});
