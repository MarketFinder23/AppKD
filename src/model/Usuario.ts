import { Table, Column, Model, ForeignKey } from 'sequelize-typescript';
import { endereco } from './Endereco';

@Table
export class usuario extends Model {
  @Column({ primaryKey: true, autoIncrement: true })
  id_user: number;

  @ForeignKey(() => endereco)
  @Column
  fk_Endereco: number;

  @Column
  telefone: string;

  @Column
  nome: string;

  @Column
  senha: string;

  @Column
  email: string;

  @Column
  plano: string;
}
