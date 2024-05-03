import { Table, Column, Model, ForeignKey } from 'sequelize-typescript';
import { loja } from './Loja';

@Table
export class produto extends Model {
  @Column({ primaryKey: true, autoIncrement: true })
  id_Produto: number;

  @ForeignKey(() => loja)
  @Column
  fk_loja: number;

  @Column
  nome: string;

  @Column({ type: 'bytea' })
  foto: Buffer;

  @Column({ type: 'text' })
  descricao: string;

  @Column
  preco_atq: number;

  @Column
  preco_vrj: number;

  @Column
  telefone: string;

  @Column
  email: string;

  @Column
  whatsapp: string;
}
